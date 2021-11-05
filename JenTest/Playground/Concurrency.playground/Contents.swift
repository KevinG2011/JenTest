import UIKit

///异步函数

func listPhotos(inGallery name: String) async -> [String] {
    await Task.sleep(1 * 1_000_000_000)
    return ["phones.png", "car.png", "apple.png"]
}

func downloadPhoto(named: String) async -> String {
    await Task.sleep(2 * 1_000_000_000)
    return named
}

Task {
    let firstPhoto = await downloadPhoto(named: "phones.png")
    let secondPhoto = await downloadPhoto(named: "car.png")
    let thirdPhoto = await downloadPhoto(named: "apple.png")

    let photos = [firstPhoto, secondPhoto, thirdPhoto]
}

// playground not supported
Task {
    async let firstPhoto = downloadPhoto(named: "phones.png")
    async let secondPhoto = downloadPhoto(named: "car.png")
    async let thirdPhoto = downloadPhoto(named: "apple.png")

    let photos = await [firstPhoto, secondPhoto, thirdPhoto]
}

///任务和任务组
Task {
    await withTaskGroup(of: String.self) { taskGroup in
        let photoNames = await listPhotos(inGallery: "Summer Vacation")
        for name in photoNames {
            taskGroup.async { await downloadPhoto(named: name) }
        }
    }
}

