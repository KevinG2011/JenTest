#  Podfile
#  Pods
#
#

platform :ios, '9.0'

def main_project_pods
    pod 'KVOController'
    pod 'PromisesObjC'
    pod 'YYCategories'
    pod 'lottie-ios', :path => '~/Documents/Project/iOS/lottie-ios'
    pod 'LookinServer', :configurations => ['Debug']
end

target "JenTest" do
    main_project_pods
end

target "JenUnitTests" do
    pod 'ReactiveObjC'
    pod 'PromisesObjC'
end
