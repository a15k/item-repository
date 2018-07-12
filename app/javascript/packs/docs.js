import SwaggerUi, { presets } from 'swagger-ui';
import 'swagger-ui/dist/swagger-ui.css';
import whenDomReady from 'when-dom-ready';

whenDomReady(() => {
  SwaggerUi({
    dom_id: '#swagger-docs-root',
    url: '/api/docs/v1.json',
    presets: [
      presets.apis,
    ],
    plugins: [
      // plugins.SpecIndex,
      // plugins.LayoutIndex
    ],
    //layout: ''
  });
});
