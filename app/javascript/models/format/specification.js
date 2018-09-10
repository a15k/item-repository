import IframeSettings from '../iframe-settings';

const FormatSpecification = {

  generate(format) {
    return `
  <!DOCTYPE html>
  <html>
    <head>
      <title>Format Specification for ${format.identifier}</title>
      <link rel="stylesheet" media="all" href="${IframeSettings.assets.styles}">
      <script src="${IframeSettings.assets.javascript}"></script>
    </head>
    <body>
      ${format.specification}
    </body>
  </html>
`;
  },
};

export default FormatSpecification;
