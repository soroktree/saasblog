# README

The application provides the functionality of a blog with subcription for the premium content. The idea was taken from yshmarov (Yaroslav Shmarov). The functionality has been expanded and developed from scratch.

The functionality includes: 

* Ruby version 2.7

* Database: Postgresql

* Authorization: Devise

* Payment Platform: Stripe using gem 'Stripe' wich includes
  - Stripe products means different subscription plans
  - Stripe checkout session Billing Portal where we can select subscription plan and pay for it
  - Stripe Webhooks to update payment details 

* Seeds with Faker

* Upvote and Downvote for posts with gem 'acts_as_votable'

* Tailwind css framework



