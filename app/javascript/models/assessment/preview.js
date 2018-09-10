import IframeSettings from '../iframe-settings';

const AssessmentPreview = {

  generate(assessment) {
    return `
  <!DOCTYPE html>
  <html>
    <head>
      <title>Assessment Preview for ${assessment.id}</title>
      <link rel="stylesheet" media="all" href="${IframeSettings.assets.styles}">
      <script src="${IframeSettings.assets.javascript}"></script>
    </head>
    <body>
      ${assessment.preview_html}
    </body>
  </html>
`;
  },
};

export default AssessmentPreview;
