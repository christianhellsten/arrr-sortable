# Arrr::Sortable :boat:

Sortable UI tables for Rails/ActiveRecord.

![Pagination for ActiveRecord](https://github.com/christianhellsten/arrr-sortable/raw/master/screenshot.png?raw=true "Sortable UI tables for Rails/ActiveRecord")

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'arrr-pagination', github: 'christianhellsten/arrr-pagination'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arrr-sortable

## Usage

Controller:

```ruby
class ProjectsController < ApplicationController
  Sortable = Arrr::Sortable.for(
    default: {
      column: :name,
      direction: :asc
    },
    columns: {
      name: 'projects.name'
    }
  )

  # GET /projects
  def index
    @projects, @table = Sortable.for(
      params: params,
      relation: current_account.projects
    )
  end
end
```

View:

```ruby
table.table
  thead
    tr
      th
        a href=@table.url_for(self, :account) Account #{@table.icon_for(:account)}
      th
        a href=@table.url_for(self, :project) Project #{@table.icon_for(:project)}
      th Roles
      th
```

## Performance

Performance is :thumbsup:

## Plugins

:pig_nose: :electric_plug:

## Advanced usage

:thumbsup:

## Bootstrap integration

:thumbsup:

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/christianhellsten/arrr-sortable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Arrr::Sortable project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/christianhellsten/arrr-sortable/blob/master/CODE_OF_CONDUCT.md).
