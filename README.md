# README

The application provides the functionality of a blog with subcription for the premium content. The idea was taken from yshmarov (Yaroslav Shmarov). The functionality has been expanded and developed from scratch.

The functionality includes: 

* Ruby version 2.7

* Database: Postgresql

* Authorization: Devise

* Payment Platform: Stripe using gem 'Stripe' wich includes
  - Create Stripe products that means different subscription plans
  - Stripe checkout session Billing Portal where we can select subscription plan and pay for it
  - Stripe Webhooks to update payment details 

* Seeds with Faker

* Upvote and Downvote on posts by different users with gem 'acts_as_votable'

<img src="https://github.com/soroktree/saasblog/blob/main/app/assets/images/saas1.png" alt="screenshots" style="max-width: 100%;">
-
<img src="https://github.com/soroktree/saasblog/blob/main/app/assets/images/saas2.png" alt="screenshots" style="max-width: 100%;">







