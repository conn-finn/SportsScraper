require 'net/smtp'

#method to send the email to user
def sendEmail(content, email)
  message = <<MESSAGE_END
From: SportScraper <sportscraperOSU@gmail.com>
To: User <#{email}>
MIME-Version: 1.0
Content-type: text/html
Subject: Today's OSU News
    
#{content}
MESSAGE_END

  smtp = Net::SMTP.new 'smtp.gmail.com', 587
  smtp.enable_starttls
  smtp.start 'gmail','sportscraperOSU@gmail.com',ENV['sportScraperPassword'], :plain
  #ENV['sportScraperPassword'] because cannot have password hard coded
  # make sure you set the sportScraperPassword otherwise there will be issues
  smtp.send_message message, 'sportscraperOSU@gmail.com', email
  smtp.finish
  puts "email sent.\n"
end
