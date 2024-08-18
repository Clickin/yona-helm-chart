# yona-helm-chart
[Project YONA](https://github.com/yona-projects/yona)를 helm으로 구동하는 차트입니다.

## 주의사항
application.conf가 configmap으로 구현되었기 때문에 최초 설치 과정에서 application.secret을 업데이트하지 못합니다.
사용자가 수동으로 kubectl edit를 통해 임의의 값으로 수정한 후에는 정상적으로 사용 가능합니다.
