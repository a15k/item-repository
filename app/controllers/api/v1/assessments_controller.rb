class Api::V1::AssessmentsController < ApiController

  def show
    render json: AssessmentSerializer.new(
             Assessment.find(params[:id]),
             { include: [:questions, :'questions.solutions'] }
           ).serialized_json
  end


  def create
    json = JSON.parse(request.body.read)
    body = ActionController::Parameters.new(json)
    data = body.require(:data)

    assessment = Assessment.create!(
      data.require(:attributes)
        .permit(
          :format_id, :content,
        )
        .merge(created_by: current_user)
    )

    create_assessment_relationships(assessment, data.fetch(:relationships, nil))

    render status: :created, json: AssessmentSerializer.new(
             assessment,
             { include: [:questions, :'questions.solutions'] }
           ).serialized_json
  end

  private

  def create_assessment_relationships(assessment, relationships)
    return unless relationships
    subtree_data = relationships.fetch(:questions).require(:data)
    return if subtree_data.empty?

    subtree_data.map do |q_data|
      attrs = q_data.require(:attributes).permit(:format_id, :content)
      question = assessment.questions.create!(attrs.merge(created_by: current_user))

      question_relations = q_data.fetch(:relationships, nil)
      next unless question_relations

      solution_data = question_relations.fetch(:solutions).require(:data)
      next if solution_data.empty?

      solution_data.map do |s_data|
        attrs = q_data.require(:attributes).permit(:format_id, :content)

        question.solutions.create!(attrs.merge(created_by: current_user))
      end

    end

  end

end
