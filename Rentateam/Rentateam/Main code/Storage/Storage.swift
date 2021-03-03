import Foundation

public class Storage {
    
    static let shared = Storage()
    
    let feed: FeedStorage
    let images: BackupManager
    let dataBackup: BackupManager

    let dataBackupKey = "dataBackupKey"
    var dataStorage: [Data] = [] {
        didSet {
            dataBackup[dataBackupKey] = dataStorage
        }
    }
    
    fileprivate init() {
        feed = .init()
        images = .shared
        dataBackup = .shared
    }
}
