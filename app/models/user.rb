class User < ApplicationRecord
	has_secure_password
	include RememberMe::Model
end
