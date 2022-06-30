class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :content, length: {minimum: 250}
    validates :summary, length: {maximum: 250}
    validates :category, inclusion: { in: %w(Fiction Non-Fiction)}
    validate :title_is_clickbait

    private

    def title_is_clickbait
        clickbait = [
            /Won't Believe/,
            /Secret/,
            /Top [0-9]+/,
            /Guess/
        ]

        if title.nil? then
            errors.add(:title, "must not be nil")
            return
        end

        clickbait.each do |c|
            if self.title.match(c) then return ; end
        end

        errors.add(:title, "must be clickbait")
    end
end
