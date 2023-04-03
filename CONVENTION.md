# Team Convention

> 해당 내용을 읽고 지킬 수 있도록 부탁드립니다. 

## Git

### 1. Branch 생성하기

> 브랜치 생성, 분기 그리고 병합과 관련한 내용을 포함합니다.

1.1. `feat/issue-name`

- 신규 기능을 작업하기 위한 이슈가 등록된 상태라면 해당 브랜치를 생성합니다.

  ```bash
  $git branch # 현재 브랜치를 확인합니다.
  $git branch -d feat/issue-name # 브랜치를 생성하고 스위치합니다.
  ```

1.2. `styl/issue-name`

- UI / UX 작업을 하기 위한 이슈가 등록된 상태라면 해당 브랜치를 생성합니다.

  ```bash
  $git branch # 현재 브랜치를 확인합니다.
  $git branch -d styl/issue-name # 브랜치를 생성하고 스위치합니다.
  ```

1.3.  `test/drive+version-code`

- 진행되는 작업들이 모두 완료되어 해당 마일스톤이 완료 상태일 때 생성합니다.

- feat, styl 브랜치를 병합하고 통합 테스트를 진행하는 브랜치입니다.

  ```bash
  $git branch # 현재 브랜치를 확인합니다.
  $git branch -d test/drive+version-code # 예) drive+1
  ```

1.4.  `release/version+version-code`

- 애플리케이션 배포 단계에서 생성하는 브랜치입니다.

- 통합 테스트 완료 후 내용이 병합된 main 브랜치에서 분기됩니다.

  ```bash
  $git branch # 현재 브랜치를 확인합니다.
  $git branch -d test/version+version-code # 예) 1.0.0+1
  ```

---

### 2. Commit

- 커밋 메세지는 `type: subject` 형식으로 작성합니다. 이때 spacing은 `:` 앞에 한 번만 사용합니다.
- `:(콜론)`은 `type`에 붙여서 사용하고 subject와는 간격을 두어야 합니다.
- subject 작성 시 첫 단어로 영어를 사용할 경우 반드시 대문자로 시작해야 하며, 다음 단어는 spacing후 소문자로 작성합니다.
- 메세지를 끝맺을 때 `., !, -, ?`와 같은 마침표 문자를 사용하지 않습니다.
- `(#n)`문자는 연결된 이슈가 있으면 사용합니다. 이때 `#n`은 이슈 번호입니다.
- `delete` 구분자는 파일을 완전히 삭제할 때 사용합니다. 파일 내용 중 일부분을 변경한거라면 `modified`를 사용합니다.

### 2.1. 표기법 예시

2.1.1. `feat`
- 기능을 구현했을 때 사용하는 구분자입니다.

  ```bash
  $git commit -m "feat: 구글 로그인"
  $git commit -m "feat(#n): 구글 로그인"
  ```

2.1.2. `add`

- 파일을 추가할때 사용하는 구분자입니다.

  ```bash
  $git commit -m "add: 로그인 블록 아키텍처"
  $git commit -m "add(#n): 로그인 블록 아키텍처"
  ```

2.1.3. `modified`

- 파일 내용을 변경할 때 사용하는 구분자입니다.

  ```bash
  $git commit -m "modified: 게시판 구조"
  $git commit -m "modified(#n): 게시판 구조"
  ```

2.1.4. `delete`

- 파일을 완전히 삭제하거나 내용 중 일부분 삭제하는 경우 사용합니다.

  ```bash
  $git commit -m "delete: 커브 애니메이션"
  $git commit -m "delete(#n): 커브 애니메이션"
  ```

2.1.5. `update`

- 중요한 파일의 버전 관리 또는 업데이트할 때 사용합니다.

  ```bash
  $git commit -m "update: 안드로이드 빌드 버전"
  $git commit -m "update(#n): 안드로이드 빌드 버전"
  ```

2.1.6. `style`

- UI / UX 스타일링 작업 시 사용하는 구분자입니다.

  ```bash
  $git commit -m "style: 회원가입 스크린"
  $git commit -m "style(#n): 회원가입 스크린"
  ```

2.1.7. `fix`

- 파일의 치명적인 문제를 해결할 때 사용하는 구분자입니다.

  ```bash
  $git commit -m "fix: Current position method"
  $git commit -m "fix(#n): Current position method"
  ```

2.1.8. `docs`

- 문서 작업 또는 문서의 내용을 수정할 때 사용하는 구분자입니다.

  ```bash
  $git commit -m "docs: 자동커밋 설정 내용 제거"
  $git commit -m "docs(#n): 자동커밋 설정 내용 제거"
  ```

### 2. 혼용 표기법

> 한/영단어를 섞어 사용해도 좋지만, 되도록 한글 또는 영문으로 표기하는 것을 추천합니다.

#### 2.1. 혼용 표기법 예시

```bash
$git commit -m "delete(#n): Curve 효과"

$git commit -m "fix(#n): 버그수정 적용"

$git commit -m "delete(#n): 불필요한 파일 삭제"

$git commit -m "docs(#n): 문서 추가"
```

## Dart

- Dart 언어와 관련해서 문서화가 필요한 내용은 이 부분에 추가됩니다.
- analyze 설정과 관련해서도 이 부분에 추가할 예정입니다.

## Flutter

- Flutter SDK는 업데이트 주기가 매우 잦습니다.
- 네이티브 코드를 대응하기 위한 것도 있겠으나, 최적화도 꾸준하게 작업하고 있는 것 같습니다.
- 따라서 주기적으로 갱신 여부를 확인해줍시다.
  ```bash
  $flutter doctor -v
  $flutter upgrade
  ```
- 이제 스키아 엔진에서 Impeller 엔진으로 교체한다고 합니다.
- iOS에서 더 좋은 성능을 보여준다고 합니다.


