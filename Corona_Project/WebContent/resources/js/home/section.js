new Vue({
    el: ".fullpage",
    data: {
        preloader: true,
        load: true,
        mainPage: false,
        widthLoad: 50,
        showMenu: false,
        menuIcon: false
    },
    methods: {
        closeLoad() {
            this.preloader = false;
        },
        open() {
            event.target.classList.toggle("open");
            this.showMenu = !this.showMenu;
        }
    },
    computed: {
        animatedPreload() {
            var time = setInterval(() => {
                if (this.widthLoad >= 100) {
                    setTimeout(() => {
                        this.$refs.load.style.opacity = 0;
                    }, 300);
                    setTimeout(() => {
                        this.load = false;
                    }, 600);
                    setTimeout(() => {
                        this.preloader = false;
                    }, 1600);
                    setTimeout(() => {
                        this.mainPage = true;
                    }, 2600);
                    setTimeout(() => {
                        this.menuIcon = true;
                    }, 3600);
                    clearInterval(time);
                }

                function getRandomInt(min, max) {
                    return Math.floor(Math.random() * (max - min)) + min;
                }
                this.widthLoad += getRandomInt(1, 20);
                this.$refs.inload.style.width = this.widthLoad + "%";
            }, 500);
        }
    },
});