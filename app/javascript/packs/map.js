// ブートストラップ ローダ
(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.Maps_API_Key
});


// ライブラリの読み込み
let map;

const mapTarget = document.querySelector("#map")
const mapData = mapTarget.dataset
const lat = parseFloat(mapData.lat)
const lng = parseFloat(mapData.lng)
const position = { lat: lat, lng: lng }

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");

  // 地図の中心と倍率は公式から変更しています。
  map = new Map(document.getElementById("map"), {
    center: position, 
    zoom: 15,
    mapTypeControl: false
  });
}

if (lat === 0.0 && lng === 0.0) {
  mapTarget.innerHTML = `
    <div class="card text-center">
      <div class="card-body">
        no-mapdata
        [${lat}, ${lng}]
      </div>
    </div>
  `
} else {
  initMap()
}
