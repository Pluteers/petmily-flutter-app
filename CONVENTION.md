# Team Convention

> 내용을 읽고 숙지 부탁드립니다.

## Git

### 1. Branch 생성하기

> 브랜치 생성, 분기 그리고 병합과 관련한 내용을 포함합니다.

1.1. `feat/issue-name`

- 신규 기능을 작업하기 위한 이슈가 등록된 상태라면 해당 브랜치를 생성합니다.

  ```bash
  $ git branch # 현재 브랜치를 확인합니다.
  $ git branch -d feat/issue-name # 브랜치를 생성하고 스위치합니다.
  ```

---

1.2. `styl/issue-name`

- UI / UX 작업을 하기 위한 이슈가 등록된 상태라면 해당 브랜치를 생성합니다.

  ```bash
    $ git branch # 현재 브랜치를 확인합니다.
    $ git branch -d styl/issue-name # 브랜치를 생성하고 스위치합니다.
  ```

---

1.3.`test/drive+version-code`

> 진행되는 작업들이 모두 완료되어 해당 마일스톤이 완료 상태일 때 생성합니다.

- feat, styl 브랜치를 병합하고 통합 테스트를 진행하는 브랜치입니다.

  ```bash
  $ git branch # 현재 브랜치를 확인합니다.
  $ git branch -d test/drive+version-code # 예) drive+1
  ```

---

1.4. `release/version+version-code`

> 애플리케이션 배포 단계에서 생성하는 브랜치입니다.

- 통합 테스트 완료 후 내용이 병합된 main 브랜치에서 분기됩니다.

  ```bash
  $ git branch # 현재 브랜치를 확인합니다.
  $ git branch -d test/version+version-code # 예) 1.0.0+1
  ```
