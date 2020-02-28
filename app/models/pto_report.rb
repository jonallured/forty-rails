class PtoReport
  def self.generate_for(user, year)
    report = new(user, year)
    report.generate
    report
  end

  attr_reader :year, :entries, :grand_total, :ytd_total

  def initialize(user, year)
    @user = user
    @year = year.to_i
  end

  def generate
    compute_work_days
    compute_entries
    compute_grand_total
    compute_ytd_total
  end

  def prev_year
    year - 1
  end

  def next_year
    year + 1
  end

  private

  def compute_work_days
    beginning_of_year = Date.parse([year.to_s, '01', '01'].join('-'))
    end_of_year = Date.parse([year.to_s, '12', '31'].join('-'))

    @work_days = @user.work_days
                      .where(date: beginning_of_year..end_of_year)
                      .where.not(pto_minutes: nil)
                      .order(:date)
  end

  def compute_entries
    @entries = @work_days.map(&PtoEntry.method(:new))
  end

  def compute_grand_total
    grand_total_minutes = @work_days.map(&:pto_minutes).compact.sum
    grand_total_time = FortyTime.parse(grand_total_minutes)
    @grand_total = grand_total_time.to_s
  end

  def compute_ytd_total
    ytd_work_days = @work_days.where('date < ?', Time.zone.today)
    ytd_total_minutes = ytd_work_days.map(&:pto_minutes).compact.sum
    ytd_total_time = FortyTime.parse(ytd_total_minutes)
    @ytd_total = ytd_total_time.to_s
  end
end
