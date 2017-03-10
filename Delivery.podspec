Pod::Spec.new do |s|

    s.name         = 'Delivery'
    s.version      = '1.0.0'
    s.license      = { :type => 'MIT' }
    s.homepage     = 'https://github.com/aleksei-z/Delivery'
    s.authors      = { 'Aleksei Zaikin' => 'aleksi.zaikin@gmail.com' }
    s.summary      = 'NotificationCenter wrapper for Swift.'
    s.source       = { :git => 'https://github.com/aleksei-z/Delivery.git', :tag => s.version }
    s.source_files = 'Sources/*.swift'

    s.ios.deployment_target  = '8.0'
    s.osx.deployment_target  = '10.11'
    s.tvos.deployment_target  = '9.0'
    s.watchos.deployment_target  = '2.0'

end
