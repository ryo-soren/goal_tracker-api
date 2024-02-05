Goal.destroy_all
User.destroy_all
Completion.destroy_all

PASSWORD = "123"

(1..3).each do |i|
    first_name = "test#{i}"
    last_name = "test#{i}"
    User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name}@#{last_name}.com",
    username: "#{first_name}_#{last_name}",
    password: PASSWORD
    )
end

users = User.all

(1..20).each do |i|
    frequency = ["one_time", "yearly", "daily", "weekly", "monthly"]
    # deadline = Time.current + i.days
    # time = 

    g = Goal.create(
        user: users.sample,
        title: "test#{i}",
        description: "Description for test #{i}",
        frequency: frequency.sample,
        times: rand(2..10),
        # deadline: Time.current(deadline.year, deadline.month, deadline.day),
        deadline: Time.current() + i.days,
        successful: rand(1..10),
        unsuccessful: rand(0..10)
    )

    if g.valid?
        rand(1...g.times).times do |i|
            # completion_date = Time.current + i.days
            # completion_time = Time.current + i.days
                
            Completion.create(
                goal: g,
                user: g.user,
                # created_at: Time.current(completion_date.year, completion_date.month, completion_date.day)
                created_at: Time.current() - i.days
            )
        end
    end
    g.done = g.completions.count
    g.save!
end

goals = Goal.all
completions = Completion.all

puts users.count
puts goals.count
puts completions.count