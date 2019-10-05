require "mechanize"
require_relative 'sendEmail'
require_relative 'ScraperSites'

scraperSites = getSites
time = Time.new
testFile = File.new("testFile.txt", "w")

agent = Mechanize.new #needed for the mechanize gem

emailContent = ""

#tell the user about the day and time getting the information
emailContent.concat("<h2>Today is: " + time.month.to_s + "/" + time.day.to_s + "/" + time.year.to_s + "</h2>\n")
emailContent.concat("<h2>Sports News today:</h2>")

testFile.write("<h2>Today is: " + time.month.to_s + "/" + time.day.to_s + "/" + time.year.to_s + "</h2>\n")
testFile.write("<h2>Sports News today:</h2>")

scraperSites.each do |sport|
  sport.each do |website|
    testFile.write "\n\n<h2>" + website.name + "</h2>\n"
    emailContent.concat "\n\n<h2>" + website.name + "</h2>\n"
    htmlPage = agent.get website.url #mechanize getting the information

    storyInfo = Array.new
    # titleInfo = Array.new
    description = true
    if website.descriptionCss.length > 0
      moreInfo = htmlPage.css website.descriptionCss
      moreInfo.each do |info|
        storyInfo.push info.text
      end
      sleep(0.1)
    else
      description = false
    end

    articles = htmlPage.css website.headlineCss
    hCounter = 0
    articles.each do |headline|
      hCounter += 1
      break unless hCounter <= 10
      title = headline.text

      storyInfo.push " " unless description
      linkToArticle = (headline.at "a[href]")['href'] #get links to the articles' pages from anchor tags
      linkToArticle = website.url + linkToArticle

      if (website.name == "Blue Jackets") then
        title = (headline.at "h4").text
      end

      testFile.write "<h3>" + hCounter.to_s + ") " + title.lstrip +
                              " <a href=\"" + linkToArticle + "\" style=\"font-size:80%;\">More Info</a></h3>\n<p>" +
                              storyInfo[hCounter-1].lstrip + "</p>\n"
      emailContent.concat "<h3>" + hCounter.to_s + ") " + title.lstrip +
                              " <a href=\"" + linkToArticle + "\" style=\"font-size:80%;\">More Info</a></h3>\n<p>" +
                              storyInfo[hCounter-1].lstrip + "</p>\n"

    end #end of headline
  end #end of website
end #end of sport
#end of all sites
testFile.close
invalid = true
while (invalid)
  invalid = false

#ask the user if they would like info over email
  puts "Would you like sports news emailed to you? Type Y for yes or N for no:"
  answer = gets
  if (answer.start_with?("Y") || answer.start_with?("y"))
    puts "Enter your email address:"
    email = gets
    email = email.chomp
    sendEmail(emailContent, email)
  else
    unless (answer.start_with?("N") || answer.start_with?("n"))
      puts "Invalid response"
      invalid = true
    end
  end
end

