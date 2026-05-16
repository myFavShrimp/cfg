Never use inline `style="..."` attributes in HTML, templates (maud/JSX/Handlebars/etc.), or component code. CSS/SCSS classes only.

If a one-off layout helper is needed, add a properly named class to the relevant stylesheet and nest it to mirror the HTML structure. Do not reach for inline styles as a shortcut — even for a single property.
