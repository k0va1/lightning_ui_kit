require "test_helper"
require "ostruct"

class LightningUiKit::SortingTest < ActiveSupport::TestCase
  FakeRelation = Struct.new(:ordered_by) do
    def order(args)
      self.class.new(args)
    end
  end

  def rows
    [
      {"name" => "Beta", "count" => 2},
      {"name" => "Alpha", "count" => 3},
      {"name" => "Gamma", "count" => 1}
    ]
  end

  def test_orders_relation_with_whitelisted_param
    relation = FakeRelation.new(nil)
    result = LightningUiKit::Sorting.apply(relation, {sort: "name", direction: "desc"}, allowed: %w[name])

    assert_equal({"name" => :desc}, result.ordered_by)
  end

  def test_ignores_param_not_in_whitelist
    relation = FakeRelation.new(nil)
    result = LightningUiKit::Sorting.apply(relation, {sort: "password", direction: "asc"}, allowed: %w[name])

    assert_same relation, result
  end

  def test_falls_back_to_default_sort
    relation = FakeRelation.new(nil)
    result = LightningUiKit::Sorting.apply(relation, {}, allowed: %w[name], default: :name, default_direction: :desc)

    assert_equal({"name" => :desc}, result.ordered_by)
  end

  def test_invalid_direction_falls_back_to_asc
    relation = FakeRelation.new(nil)
    result = LightningUiKit::Sorting.apply(relation, {sort: "name", direction: "DROP TABLE"}, allowed: %w[name])

    assert_equal({"name" => :asc}, result.ordered_by)
  end

  def test_sorts_array_of_hashes
    result = LightningUiKit::Sorting.apply(rows, {sort: "name", direction: "asc"}, allowed: %w[name])

    assert_equal %w[Alpha Beta Gamma], result.map { |row| row["name"] }
  end

  def test_sorts_array_descending
    result = LightningUiKit::Sorting.apply(rows, {sort: "count", direction: "desc"}, allowed: %w[count])

    assert_equal [3, 2, 1], result.map { |row| row["count"] }
  end

  def test_sorts_array_of_objects_by_method
    people = [OpenStruct.new(age: 30), OpenStruct.new(age: 20)]
    result = LightningUiKit::Sorting.apply(people, {sort: "age", direction: "asc"}, allowed: %w[age])

    assert_equal [20, 30], result.map(&:age)
  end

  def test_returns_scope_untouched_without_param_or_default
    result = LightningUiKit::Sorting.apply(rows, {}, allowed: %w[name])

    assert_equal rows, result
  end

  def test_custom_param_names
    relation = FakeRelation.new(nil)
    result = LightningUiKit::Sorting.apply(relation, {order_by: "name", dir: "desc"}, allowed: %w[name], sort_param: :order_by, direction_param: :dir)

    assert_equal({"name" => :desc}, result.ordered_by)
  end
end
