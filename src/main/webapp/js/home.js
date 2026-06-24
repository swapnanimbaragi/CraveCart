const videos = [
    "/JEEProject/videos/Veggs.mp4",
    "/JEEProject/videos/Panner2.mp4",
    "/JEEProject/videos/Biriyani.mp4",
    "/JEEProject/videos/Chicken.mp4",
    "/JEEProject/videos/Chicken2.mp4",
    "/JEEProject/videos/Pizza2.mp4"
];

let currentVideo = 0;

const heroVideo = document.getElementById("heroVideo");
const heroSource = document.getElementById("heroSource");

heroVideo.addEventListener("ended", () => {

    currentVideo++;

    if(currentVideo >= videos.length)
    {
        currentVideo = 0;
    }

    heroSource.src = videos[currentVideo];

    heroVideo.load();

    heroVideo.play();
});