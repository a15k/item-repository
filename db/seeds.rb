# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

OX = 'OpenStax'


unless Member.exists?(name: OX)
  Member.create!(name: OX, website: 'openstax.org')
end

OX_MEMBER = Member.find_by(name: OX)
unless User.exists?(member_id: OX_MEMBER.id)
  account = OpenStax::Accounts::Account.create!(
    uuid: SecureRandom.uuid
  )
  User.create!(member_id: OX_MEMBER.id, account_id: account.id)
end

unless Format.exists?(name: OX)
  Format.create!(
    name: OX,
    specification: 'Openstax exercise format, see https://openstax.org/ for details',
    created_by: OX_MEMBER
  )
end
