        // MARK: TEST dummy data 박스오피스 순위
        Dummy().create { [weak self] dummy in
            guard let self = self else { return }
            self.boxOffice = dummy
            DispatchQueue.main.async {
                self.updateItems()
            }
        }
