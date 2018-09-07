import { observable } from 'mobx';

const AssessmentPreview = {

  @observable assets: '',

  generate(assessment) {
    return `
  <!DOCTYPE html>
  <html>
    <head>
      <title>Assessment Preview for ${assessment.id}</title>
      <link rel="stylesheet" media="all" href="${this.assets.styles}">
      <script src="${this.assets.javascript}"></script>
    </head>
    <body>
      ${assessment.preview_html}
    </body>
  </html>
`;
  },
};

export default AssessmentPreview;
