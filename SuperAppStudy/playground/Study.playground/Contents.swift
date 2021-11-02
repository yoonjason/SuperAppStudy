import UIKit

//리블렛이란
//빌더, 인터렉터, 라우터, 뷰로 이루어진 하나의 단위를 묶은걸 부른다.

/*
 1. 하나의 로직의 단위는 리블렛이다.
 2. 빌더는 리블렛의 객체들을 생성하고 라우터를 리턴하는 역할을한다.
 3. 인터랙터는 로직이 들어가는 곳으로 두뇌같은 역할
 4. 라우터는 리블렛 트리를 만들고 뷰나 뷰컨트롤러간의 라우팅을 담당하는 역할 자식리블렛을 붙이고 싶으면 자식 리블렛의 빌더를 만들고 빌드 메서드를 통해서 라우터를 받아와서 어태치 차일드를 하고 뷰컨트롤러를 띄운다.
 
 
 빌더는 리블렛 객체를 생성한다
 앱 빌더는 앱
 
 빌드 메서드에서 리블레세에 필요한 객체를 생성한다.
 
 하나의 부모 리블렛을 가지고 있고, 여러개의 자식 리블렛을 가질 수 있다.
 빌더는 리블렛을생성한다?
 
 자식 리블렛을 붙이는건 빌더가 한다.
 
 */
