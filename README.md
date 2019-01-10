#### RAC+MVVM 搭建的电子书demo

![demo](https://github.com/dengfeng520/ReadingDemo-OC/blob/master/demo3.gif?raw=true)
首页列表滚动时停止下载图片当滑动停止时下载图片，参考了[Apple Developer LazyTablbe Demo](https://developer.apple.com/library/archive/samplecode/LazyTableImages/Introduction/Intro.html)
，当然也可以使用[RunLoop](https://developer.apple.com/documentation/foundation/nsrunloop?language=objc)的方式进行优化。
同时demo中也使用了内存缓存和硬盘缓存优化处理。