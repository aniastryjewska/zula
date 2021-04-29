<br />
<p align="center">
  <!-- <a href="https://github.com/shinroo/zula">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a> -->

  <h3 align="center">Zula, The Reading Tribe</h3>

  <p align="center">
    Welcome to our github docs
    <br />
    <a href="https://github.com/shinroo/zula"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://reading-tribe.anvil.app/">View Demo</a>
    ·
    <a href="https://github.com/shinroo/zula/issues">Report Bug</a>
    ·
    <a href="https://github.com/shinroo/zula/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

Zula is on the mission to amplify diversity and inclusion in childrens libraries and bookshelves around the globe and especially in white dominated Countries and Societies. Zula is a Digital Reading Library.

Our approach is to use technology to make access to these books available and affordable anywhere, and support the education of children raised in disadvantaged families anywhere by providing them with free access to books.


### Built With

This section should list any major frameworks that you built your project using. Leave any add-ons/plugins for the acknowledgements section. Here are a few examples.
* React
* Directus
* Postgres
* Docker

<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Prerequisites

The following software should be installed prior to using zula locally:
1. docker
2. docker-compose

The project also needs a `.env` file at the root of the folder structure to work correctly.

Use this template:
```
POSTGRES_USER=directus
POSTGRES_PASSWORD=directus
POSTGRES_DB=directus
KEY= add a uuid here
SECRET= add a uuid here
DB_CLIENT=pg
DB_HOST=zula-db
DB_PORT=5432
DB_DATABASE=directus
DB_USER=directus
DB_PASSWORD=directus
CACHE_ENABLED=true
CACHE_STORE=redis
CACHE_REDIS=redis://zula-cache:6379
ADMIN_EMAIL=admin@example.com
ADMIN_PASSWORD=d1r3ctu5
```

### Installation

1. Clone the repo to your local machine

```sh
git clone https://github.com/shinroo/zula
```

Or your own fork if you are a contributor

2. Enter the repo

```sh
cd zula
```

3. Build the docker images

```
docker-compose build
```

4. Start the system...

_with logs in the terminal:_

```sh
docker-compose up
```

_without logs in the terminal:_

```sh
docker-compose up -d
```

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/shinroo/zula/issues) for a list of proposed features (and known issues). More information available on the team Notion.

<!-- LICENSE -->
## License

Distributed under the GPL-2 License. See `LICENSE` for more information.


<!-- CONTACT -->
## Contact

Project Link: [Zula](https://github.com/shinroo/zula)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* Robert Focke