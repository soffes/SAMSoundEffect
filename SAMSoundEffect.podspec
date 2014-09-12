Pod::Spec.new do |s|
  s.name = 'SAMSoundEffect'
  s.version = '0.1.0'
  s.authors = {'Sam Soffes' => 'sam@soff.es'}
  s.homepage = 'https://github.com/soffes/SAMSoundEffect'
  s.summary = 'A simple way to play a sound effect on iOS.'
  s.source = {:git => 'https://github.com/soffes/SAMSoundEffect.git', :tag => "v#{s.version}"}
  s.license = { :type => 'MIT', :file => 'LICENSE' }

  s.platform = :ios
  s.requires_arc = true
  s.frameworks = 'Foundation', 'AVFoundation'
  s.source_files = 'SAMSoundEffect'
end
