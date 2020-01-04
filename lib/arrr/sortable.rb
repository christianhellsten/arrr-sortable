require "arrr/sortable/version"

module Arrr
  module Sortable
    def self.for(columns:, default:)
      Arrr::Sortable::Configuration.new(columns: columns, default: default)
    end

    # Configuration holds the page-specific configuration
    class Configuration
      attr_reader :default_column
      attr_reader :default_db_column
      attr_reader :default_direction
      attr_reader :columns

      DIRECTIONS = {
        asc: :asc,
        desc: :desc
      }.with_indifferent_access.freeze

      def initialize(columns:, default:)
        @columns = columns.with_indifferent_access.freeze
        @default_column = default.fetch(:column)
        @default_direction = default.fetch(:direction)
        @default_db_column = @columns.fetch(default_column)
      end

      def for(params:, relation:)
        params = params.permit(:direction, :order_by) if params.respond_to?(:permit)
        direction = DIRECTIONS.fetch(params[:direction], default_direction).to_sym
        column = (columns.key?(params[:order_by]) ? params[:order_by] : default_column).to_sym
        db_column = columns.fetch(column, default_db_column)
        ordered_relation = relation.order(db_column => direction)
        order_by = Sortable::Table.new(
          column: column,
          db_column: db_column,
          direction: direction,
          relation: relation
        )
        [ordered_relation, order_by]
      end
    end

    # Table holds all data needed by the view.
    class Table
      attr_reader :relation
      attr_reader :column
      attr_reader :db_column
      attr_reader :direction

      def initialize(params)
        @relation = params.fetch(:relation)
        @column = params.fetch(:column)
        @db_column = params.fetch(:db_column)
        @direction = params.fetch(:direction)
      end

      def url_for(view, value)
        direction = column == value ? alt_direction : direction
        view.url_for(order_by: value, direction: direction)
      end

      def icon_for(value)
        if column == value && direction == :desc
          '&uarr;'.html_safe
        elsif column == value && direction == :asc
          '&darr;'.html_safe
        else
          '&udarr;'.html_safe
        end
      end

      def alt_direction
        if direction == :desc
          :asc
        else
          :desc
        end
      end
    end
  end
end
