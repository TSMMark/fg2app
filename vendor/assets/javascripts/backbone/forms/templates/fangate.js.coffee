###
Include this template file after backbone-forms.amd.js to override the default templates

'data-*' attributes control where elements are placed
###
((Form) ->

  ###
  Fangate templates for Backbone Forms
  ###
  Form.template = _.template '
    <form class="" data-fieldsets></form>'
  Form.Fieldset.template = _.template '
    <fieldset data-fields>
      <% if (legend) { %>
        <legend><%= legend %></legend>
      <% } %>
    </fieldset>'
  Form.Field.template = _.template '
    <div class="control-group field-<%= key %>">
      <label for="<%= editorId %>">
        <%= title %>
      </label>
      <div class="controls">
        <div class="help-block"><%= help %></div>
        <span data-editor></span>
        <div class="help-inline" data-error></div>
      </div>
    </div>'
  # Form.NestedField.template = _.template '<div class="field-<%= key %>"> <div title="<%= title %>" class="input-xlarge"> <span data-editor></span> <div class="help-inline" data-error></div> </div> <div class="help-block"><%= help %></div> </div>'
  # if Form.editors.List
  #   Form.editors.List.template = _.template '<div class="bbf-list"> <ul class="unstyled clearfix" data-items></ul> <button class="btn bbf-add" data-action="add">Add</button> </div>'
  #   Form.editors.List.Item.template = _.template '<li class="clearfix"> <div class="pull-left" data-editor></div> <button type="button" class="btn bbf-del" data-action="remove">&times;</button> </li>'
  #   Form.editors.List.Object.template = Form.editors.List.NestedModel.template = _.template '<div class="bbf-list-modal"><%= summary %></div>'
) Backbone.Form