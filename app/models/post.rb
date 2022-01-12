class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: ["Fiction", "Non-Fiction"]}

  #Custom Validation
  validate :clickbait?

  CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top \d/i,
    /Guess/i
  ]

  def clickbait?
    # ".none?" returns true if none of the elements match the given block.
    # https://apidock.com/rails/Enumerable/none%3F
    if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
      errors.add(:title, "must be clickbait")
    end
  end

end
