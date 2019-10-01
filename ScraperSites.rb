class ElevenWarriors
  def initialize
    @name = "Eleven Warriors"
    @url = "https://www.elevenwarriors.com/"
    @headlineCss = "#main-content .node-article .node-title"
    @descriptionCss =".article-content .description"
    @fullPath = "#main-content .node-article .node-title a .short-title"
  end
  def name
    @name
  end
  def url
    @url
  end
  def headlineCss
    @headlineCss
  end
  def descriptionCss
    @descriptionCss
  end
  def fullPath
    @fullPath
  end
end

class NhlWebsite
  def initialize
    @name = "Blue Jackets"
    @url = "https://www.nhl.com/bluejackets/"
    @headlineCss = ".mixed-feed__list li :nth-child(2) :first-child"
    @descriptionCss = ""
    @fullPath = ".mixed-feed__list li mixed-feed__meta a h4"
  end
  def name
    @name
  end
  def url
    @url
  end
  def headlineCss
    @headlineCss
  end
  def descriptionCss
    @descriptionCss
  end
  def fullPath
    @fullPath
  end
end

def getSites
  elevenWarriorsFootball = ElevenWarriors.new
  cbjHockey = NhlWebsite.new
  footballSites = [elevenWarriorsFootball]
  hockeySites = [cbjHockey]
  sites = [footballSites, hockeySites]
  sites #return array of sports arrays containing websites for each sport
end