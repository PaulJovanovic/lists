module Scoring
  def self.included(base)
    # base.after_save :calculate_score, if: "scores_count.changed?"
  end

  def score!(actionable, weight)
    Score.create(scorable: self, actionable: actionable, weight: weight)
    calculate_scores
  end

  def calculate_scores
    calculate_current_score
    calculate_total_score
  end

  def calculate_current_score
    update_column(:current_score, scores.where("created_at > ?", 1.week.ago).sum(:weight))
  end

  def calculate_total_score
    update_column(:total_score, scores.sum(:weight))
  end
end
