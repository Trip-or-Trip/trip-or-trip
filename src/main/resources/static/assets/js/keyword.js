let container = document.querySelector("#result-container");
let title, addr, latitude, longitude, url;

document.querySelector("#keyword-search-btn").addEventListener("click", function() {
	let keyword = document.querySelector("#search-keyword").value;
	
	if(!keyword) {
		alert("장소를 입력해 주세요.");
	}
	else {
		while(container.hasChildNodes()) {
			container.removeChild(container.firstChild);
		}
		
		let ps = new kakao.maps.services.Places(); // 장소 검색 객체 생성
		
		let callback = function(result, status) {
			if(status === kakao.maps.services.Status.OK) {
				displaySearchResult(result);
			}
			else if(status === kakao.maps.services.Status.ZERO_RESULT) {
				alert("검색 결과가 없습니다. 다시 시도해 주세요.");
			}
			else {
				alert("서버에 문제가 있습니다. 다시 시도해 주세요.");
			}
		};

		ps.keywordSearch(keyword, callback);
	}
});

let prev;

function displaySearchResult(result) {
	console.log(result);
	
	let content = "";
	
	for(let i = 0; i < result.length; i++) {
		content += `
			<div class="place-container d-flex justify-content-center form-group-row" id="result-${i}">
				<div class="col-5">
					<div>${result[i].place_name}</div>
				</div>
				<div class="col-7">
					<div>${result[i].address_name}</div>
				</div>
			</div>`;
	}
	
	container.innerHTML = content;
	
	for(let i = 0; i < result.length; i++) {
		document.querySelector("#result-" + i).addEventListener("click", function() {
			console.log(prev);
			
			if(typeof prev != "undefined") {
				prev.style.border = "1px solid white";
			}
			
			this.style.borderTop = "1px solid lightgray";
			this.style.borderBottom = "1px solid lightgray";
			title = result[i].place_name;
			addr = result[i].address_name;
			latitude = result[i].y;
			longitude = result[i].x;
			url = result[i].place_url;
			prev = this;
//			selectedOne(result[i]);
		});
	}
}

document.querySelector("#title-submit-btn").addEventListener("click", function() {
	if(typeof title == "undefined" || title == null || title == "") {
		alert("장소를 선택해 주세요.");
	}
	else {
		selectedOne();
	}
});

function selectedOne() {
	opener.document.querySelector("#hotplace-title").value = title;
	opener.document.querySelector("#hotplace-latitude").value = latitude;
	opener.document.querySelector("#hotplace-longitude").value = longitude;
	opener.document.querySelector("#hotplace-map-url").value = url;
	
	opener.document.querySelector("#hotplace-update-title").value = title;
	opener.document.querySelector("#hotplace-update-latitude").value = latitude;
	opener.document.querySelector("#hotplace-update-longitude").value = longitude;
	opener.document.querySelector("#hotplace-update-map-url").value = url;
	
	window.close();
}