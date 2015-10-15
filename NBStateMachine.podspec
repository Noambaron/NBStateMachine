

Pod::Spec.new do |s|

s.name     	= "NBStateMachine"
s.version      = "0.2"
s.summary      = "Simple State Machine writen in Swift"

s.description  = <<-DESC
Simple State Machine writen in Swift.
DESC

s.homepage 	= "https://github.com/Noambaron/NBStateMachine"
#s.screenshots  = ""
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author         	= { "Noam bar-on" => "https://www.linkedin.com/in/noambaron" }
s.social_media_url = "https://www.linkedin.com/in/noambaron"
s.platform 	= :ios, "9.0"
s.source   	= { :git => "https://github.com/Noambaron/NBStateMachine.git", :tag => "0.2" }
s.source_files  = "NBStateMachine/NBStateMachine/**/*.swift"

s.requires_arc = true

end