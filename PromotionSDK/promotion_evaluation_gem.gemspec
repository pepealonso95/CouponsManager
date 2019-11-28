Gem::Specification.new do |s|
    s.name        = 'promotion_evaluation_gem'
    s.version     = '1.0.0'
    s.date        = '2019-11-01'
    s.summary     = "Gema para evaluar una promocion"
    s.description = "Gema para evaluar una promocion"
    s.authors     = ["Nicolas Damiani"]
    s.email       = 'nicodamiani95@gmail.com'
    s.files       = ["lib/promotion_evaluation_gem.rb"]
    s.license       = 'MIT'
    s.require_paths = ['lib']
    s.add_development_dependency 'bundler'
    s.add_runtime_dependency 'rest-client'
end