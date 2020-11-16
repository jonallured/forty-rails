class NullWorkWeek < BaseWorkWeek
  def find_or_create
    # noop
  end

  private

  def disabled?
    true
  end

  def week_to_date_ids
    []
  end
end
