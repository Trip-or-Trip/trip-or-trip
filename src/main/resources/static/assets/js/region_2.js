// index page 로딩 후 전국의 시도 설정.
let areaUrl =
  "https://apis.data.go.kr/B551011/KorService1/areaCode1?serviceKey=" +
  serviceKey +
  "&numOfRows=20&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json";

fetch(areaUrl, { method: "GET" })
  .then((response) => response.json())
  .then((data) => makeOption(data));

function makeOption(data) {
  let areas = data.response.body.items.item;
  // console.log(areas);
  let sel = document.getElementById("search-area");
  if (!areas) { }
  else {
    areas.forEach((area) => {
      let opt = document.createElement("option");
      // 아이디 생성
      opt.setAttribute('id', area.name);
      opt.setAttribute('class', 'search-area-content');
      opt.setAttribute("value", area.code);
      opt.appendChild(document.createTextNode(area.name));

      sel.appendChild(opt);
    });
  }
}

// 여행 계획 세우는 이벤트
// 해당 여행지를 클릭하고 include 버튼을 누르면 여행 계획란에 포함되도록 한다.
document.getElementById('include-btn').addEventListener('click', () => {
  if (!addImage || !addTitle) { }
  else {
    addTitle = addTitle.substring(0, 6) + "...";
    let makeDiv = `<div sytle="background-color: gray; width: 100%; height: 100px;">
                        <div id='trip-plan-card' class='rounded border-opacity-50 border border-primary-subtle'>${addTitle}</div>
                      </div>`;

    console.log(makeDiv);
    document.getElementById('trip-plan-container').innerHTML += makeDiv;
  }
});

// 시도 버튼을 누르면
// 해당 시도에 맞는 구 보여주기
document.getElementById('search-gungu-id').addEventListener('click', () => {
  let areaCode = document.getElementById('search-area').value;

  let searchUrl = `https://apis.data.go.kr/B551011/KorService1/areaCode1?serviceKey=${serviceKey}&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&areaCode=${areaCode}&_type=json`;

  fetch(searchUrl, { method: "GET" })
    .then((response) => response.json())
    .then((data) => makeAreaOption(data));

  function makeAreaOption(data) {
    let areas = data.response.body.items.item;
    let sel = document.getElementById('search-gungu-id');

    if (sel.childElementCount > 1) {
      let vals = document.querySelectorAll('.search-content-code');
      if (!vals) { }
      else {
        vals.forEach((val) => {
          val.remove();
        });
      }
    }
    if (!areas) { }
    else {
      areas.forEach((area) => {
        let opt = document.createElement('option');
        opt.setAttribute('value', area.code);
        opt.setAttribute('class', 'search-content-code');
        opt.setAttribute('id', area.name);
        opt.appendChild(document.createTextNode(area.name));

        sel.appendChild(opt);
      });
    }
  }
});

// 검색 버튼을 누르면..
// 지역, 유형, 검색어 얻기.
// 위 데이터를 가지고 공공데이터에 요청.
// 받은 데이터를 이용하여 화면 구성.
document.getElementById("btn-search").addEventListener("click", () => {
  document.getElementById("trip-list").innerHTML = '';
  // &contentTypeId=${contentTypeId}
  let areaCode = document.getElementById("search-area").value;
  // 시군구 코드
  let sigunguCode = document.getElementById('search-gungu-id').value;
  // 12 : 관광지 , 14 : 문화시설, 15: 축제공연행사, 25: 여행코스, 28: 레포츠, 32: 숙박, 38: 쇼핑, 39: 음식점
  let contentTypeId = document.getElementById('search-content-id').value;

  let searchUrl = `https://apis.data.go.kr/B551011/KorService1/areaBasedSyncList1?serviceKey=${serviceKey}&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json&showflag=1&listYN=Y&arrange=A`;

  if (parseInt(contentTypeId)) searchUrl += `&contentTypeId=${contentTypeId}`;
  if (parseInt(areaCode)) searchUrl += `&areaCode=${areaCode}`;
  if (parseInt(sigunguCode)) searchUrl += `&sigunguCode=${sigunguCode}`;

  fetch(searchUrl)
    .then((response) => response.json())
    .then((data) => makeList(data));

  // // 검색 버튼 누르면 include 버튼 활성화
  // let includeBtn = `<button type="button" class="btn btn-primary" id='include-btn'>include</button>`;
  // document.getElementById('trip-btn').innerHTML = includeBtn;
});

var positions; // marker 배열.
function makeList(data) {
  document.querySelector("table").setAttribute("style", "display: ;");
  let trips = data.response.body.items.item;
  let tripList = ``;
  positions = [];
  if (!trips) { }
  else {
    trips.forEach((area) => {
      tripList += `
            <tr class='trip-list-content' onclick="moveCenter(${area.mapy}, ${area.mapx}, '${area.firstimage}', '${area.title}');">
              <td class="box"><img src="${area.firstimage}" width="100px"></td>
              <td class="box">${area.title}</td>
              <td class="box">${area.addr1} ${area.addr2}</td>
            </tr>
          `;

      // console.log(tripList);

      let markerInfo = {
        title: area.title,
        latlng: new kakao.maps.LatLng(area.mapy, area.mapx),
      };
      positions.push(markerInfo);
    });
  }
  document.getElementById("trip-list").innerHTML += tripList;
  displayMarker();
}

// 카카오지도
var mapContainer = document.getElementById("map"), // 지도를 표시할 div
  mapOption = {
    center: new kakao.maps.LatLng(37.500613, 127.036431), // 지도의 중심좌표
    level: 5, // 지도의 확대 레벨
  };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption);

function displayMarker() {
  // 마커 이미지의 이미지 주소입니다
  var imageSrc = "./assets/img/icon/location.png";

  for (var i = 0; i < positions.length; i++) {
    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new kakao.maps.Size(30, 35);

    // 마커 이미지를 생성합니다
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
      map: map, // 마커를 표시할 지도
      position: positions[i].latlng, // 마커를 표시할 위치
      title: positions[i].title, // a마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
      image: markerImage, // 마커 이미지
    });
    // // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);

    // test
    console.log(positions[i]);
    var iwContent = `<div class='rounded bg-body-secondary' style="padding:5px;">${positions[i].title}<br>
                      <a class='rounded bg-secondary' style='padding: 0.3em; text-decoration: none; color: white' href="https://map.kakao.com/link/map/${positions[i].title},${positions[i].latlng.Ma},${positions[i].latlng.La}" style="color:blue" target="_blank">큰지도보기</a>
                      <a class='rounded bg-secondary' style='padding: 0.3em; text-decoration: none; color: white' href="https://map.kakao.com/link/to/${positions[i].title},${positions[i].latlng.Ma},${positions[i].latlng.La}" style="color:blue" target="_blank">길찾기</a>
                  </div>`, // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
      iwPosition = new kakao.maps.LatLng(positions[i].latlng.Ma + 0.0015, positions[i].latlng.La); //인포윈도우 표시 위치입니다

    // 커스텀 오버레이
    var customOverlay = new kakao.maps.CustomOverlay({
      // map: map,
      position: iwPosition,
      content: iwContent,
      xAnchor: 0.3,
      yAnchor: 0.91
    });

    // 인포윈도우를 생성합니다
    // var infowindow = new kakao.maps.InfoWindow({
    //     position: iwPosition,
    //     content: iwContent
    // });

    // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
    customOverlay.setMap(map);
  }

  // 첫번째 검색 정보를 이용하여 지도 중심을 이동 시킵니다
  map.setCenter(positions[0].latlng);
}

var addImage = '';
var addTitle = '';
function moveCenter(lat, lng, image, title) {
  map.setCenter(new kakao.maps.LatLng(lat, lng));

  addImage = image;
  addTitle = title;
  console.log(addImage);
}
