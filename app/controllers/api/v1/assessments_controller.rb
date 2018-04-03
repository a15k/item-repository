class Api::V1::AssessmentsController < ApiController

  def show
    render json: AssessmentSerializer.new(
             Assessment.find(params[:id]),
             { include: [:questions, :solutions] }
           ).serialized_json
  end


  def create
    json = JSON.parse(request.body.read)
    body = ActionController::Parameters.new(json)
    data = body.require(:data)

    assessment = Assessment.create!(
      data.require(:attributes).permit(:format_id)
        .merge(created_by: current_user)
    )

    create_assessment_relations(assessment, data.fetch('relationships', nil))

    render status: :created, json: AssessmentSerializer.new(
             assessment,
             { include: [:questions, :solutions] }
           ).serialized_json

  end


  private

  def create_assessment_relations(assessment, relationships)
    return unless relationships

    relations = %w[questions solutions]
    relations.each do|relation|
      relation_attrs = relationships.permit(
        Hash[relation, { data: %i[format_id content] }]
      )
      unless relation_attrs.empty?
        association = assessment.send(relation)
        relation_attrs
          .fetch(relation)
          .require(:data)
          .each{ |attrs|
          association.create!(attrs.merge(created_by: current_user))
        }
      end
    end
  end

end
