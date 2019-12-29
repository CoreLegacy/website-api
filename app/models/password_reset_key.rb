class PasswordResetKey < ApplicationRecord
    has_one :user
end