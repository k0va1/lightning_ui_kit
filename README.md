# LightningUiKit

UI components for fast prototyping in Rails applications.

Preview is available at [ui.k0va1.dev](https://ui.k0va1.dev)

## Installation

Add this line to your application's Gemfile:

```ruby
gem "propshaft"
gem "lightning_ui_kit"
```

And then execute:

```bash
$ bundle
```

Add the following lines to your `application.html.erb` file:

```erb
<%= stylesheet_link_tag "lightning_ui_kit" %>
<%= javascript_include_tag "lightning_ui_kit" %>
```

## Usage

Use the `lui` helper to render components:

```erb
<%= lui.button { "Click me" } %>
<%= lui.button(style: :outline) { "Cancel" } %>
<%= lui.button(style: :destructive, size: :small) { "Delete" } %>
```

### Form Components

```erb
<%= lui.input(name: :email, type: :email, label: "Email") %>
<%= lui.textarea(name: :bio, label: "Biography", rows: 4) %>
<%= lui.select(name: :country, label: "Country", options: [["US", "us"], ["UK", "uk"]]) %>
<%= lui.checkbox(name: :terms, label: "Accept terms") %>
<%= lui.switch(name: :notifications, label: "Enable notifications") %>
```

### With Rails Form Builder

```erb
<%= form_with model: @user do |form| %>
  <%= lui.input(name: :email, type: :email, label: "Email", form: form) %>
  <%= lui.textarea(name: :bio, label: "Biography", form: form) %>
  <%= lui.button(type: :submit) { "Save" } %>
<% end %>
```

### Components with Slots

```erb
<%= lui.modal(id: "confirm", title: "Confirm Action") do |modal| %>
  <% modal.with_body do %>
    <p>Are you sure you want to proceed?</p>
  <% end %>
  <% modal.with_action do %>
    <%= lui.button(style: :outline) { "Cancel" } %>
  <% end %>
  <% modal.with_action do %>
    <%= lui.button { "Confirm" } %>
  <% end %>
<% end %>

<%= lui.table(data: @users) do |table| %>
  <% table.with_column("Name") { |user| user.name } %>
  <% table.with_column("Email") { |user| user.email } %>
  <% table.with_action { |user| link_to "Edit", edit_user_path(user) } %>
<% end %>
```

### Available Components

**Form**: `button`, `input`, `textarea`, `select`, `checkbox`, `switch`, `combobox`, `file_input`, `dropzone`

**Display**: `text`, `badge`, `avatar`, `alert`, `banner`, `toast`, `skeleton`, `spinner`

**Structure**: `table`, `pagination`, `description_list`, `dropdown`, `modal`, `tooltip`, `layout`, `sidebar`, `sidebar_section`, `sidebar_link`, `link`

### Alternative Syntax

You can also use the standard ViewComponent render syntax:

```erb
<%= render LightningUiKit::ButtonComponent.new { "Click me" } %>
```

## Contributing

Bug reports and pull requests are welcome

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
