# LightningUiKit
UI components for fast prototyping in Rails applications.

## Usage

Add this line to your application's Gemfile:

```ruby
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

Then you can use components in your views like this:

```erb
<%= render LightningUiKit::ButtonComponent.new(text: "Click me!") %>
```

## Contributing
Bug reports and pull requests are welcome

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
