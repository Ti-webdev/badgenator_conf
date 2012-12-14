# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sets = ['Кружок кройки и шитья', 'Труды', 'Физика', 'Математика', 'Конференция']
images = %W(#{Rails.root}/db/seeds/ruby.png #{Rails.root}/db/seeds/python.jpg)
professions = %w(программист участник докладчик верстальщик порно-актер)
companies = ['ИД Абак Пресс', 'СКБ Контур', 'Jet-Style', 'IT-People', 'ПронМедиа']
people = [
  "Алексеева Юлия",
  "Алешина Татьяна",
  "Володина Ольга",
  "Вяткин Василий",
  "Горбов Алексей",
  "Гребенщикова Таня",
  "Дерновой Филипп",
  "Кондратьев Николай",
  "Коротаев Данил",
  "Крупенников Дмитрий",
  "Кузнецов Алексей",
  "Кузнецов Владимир",
  "Кузнецова Гузель",
  "Кустикова Мария",
  "Лавров Илья",
  "Лиханова Александра",
  "Логинов Андрей",
  "Малых Андрей",
  "Меньшиков Илья",
  "Меркушин Михаил",
  "Напольских Артем",
  "Олюнина Наталья",
  "Онищенко Денис",
  "Ремизова Наталья",
  "Салашов Михаил",
  "Сидоров Михаил",
  "Скороходов Александр",
  "Суханов Евгений",
  "Татауров Алексей",
  "Тыцкий Андрей",
  "Федоров Сергей",
  "Фефелов Андрей",
  "Шумков Михаил",
  "Клочков Артем",
  "Жидков Денис",
  "Скрыпская Мария",
]

5.times do |t|
  BadgeSet.create! name: sets[rand(0..4)], image: File.open(images[rand(0..1)])
end

BadgeSet.find_each(batch_size: 2) do |set|
  set.badges = rand(5..30).times.map do |t|
    Badge.new({
      name: people[rand(0..35)].split(' ').last,
      surname: people[rand(0..35)].split(' ').first,
      company: companies[rand(0..4)],
      profession: professions[rand(0..4)]
    })
  end

  set.save!
end