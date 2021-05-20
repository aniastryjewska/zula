import React, { FunctionComponent, Fragment, useState, useEffect } from "react";
import logo from "./logo.svg";
import "./App.css";
import { Directus } from "@directus/sdk";
import { BookTranslation, ZulaMap } from "./model";
import { Login } from "./components/login.component";
import {
  Button,
  Grid,
  SwipeableDrawer,
  IconButton,
  Typography,
} from "@material-ui/core";
import MenuIcon from "@material-ui/icons/Menu";
import Image from "material-ui-image";
import { Landing } from "./components/landing.component";
import { BrowserRouter as Router, Switch, Route, Link } from "react-router-dom";
import { GuardProvider, GuardedRoute } from 'react-router-guards';

interface AppProps {}

const getBooks = async (directus: Directus<ZulaMap>, fields = "*") => {
  return await directus.items("book").readMany({
    fields: fields,
  });
};

const getTranslations = async (
  directus: Directus<ZulaMap>,
  id?: string,
  fields = "*"
) => {
  return id
    ? await directus.items("translation").readMany({
        fields: fields,
        filter: {
          id: {
            _eq: id,
          },
        },
      })
    : await directus.items("translation").readMany({
        fields: fields,
      });
};

const loginUser = async (
  directus: Directus<ZulaMap>,
  userEmail: string,
  userPassword: string
) => {
  await directus.auth.login(
    {
      email: userEmail,
      password: userPassword,
    },
    {
      refresh: {
        auto: true,
      },
    }
  );
  return directus;
};

const toggleDrawer =
  (
    drawerOpen: boolean,
    setDrawerOpen: React.Dispatch<React.SetStateAction<boolean>>
  ) =>
  (event: React.KeyboardEvent | React.MouseEvent) => {
    if (
      event &&
      event.type === "keydown" &&
      ((event as React.KeyboardEvent).key === "Tab" ||
        (event as React.KeyboardEvent).key === "Shift")
    ) {
      return;
    }

    setDrawerOpen(drawerOpen);
  };

const App: FunctionComponent<AppProps> = (props) => {
  const [loggedIn, setLoggedIn] = useState<boolean>(false);
  const [directus, setDirectus] = useState<Directus<ZulaMap>>(
    new Directus<ZulaMap>("http://localhost:8055/")
  );
  const [translations, setTranslations] = useState<BookTranslation[]>([]);
  const [drawerOpen, setDrawerOpen] = useState<boolean>(false);
  console.log(directus.users.me.read());

  const requireLogin = (to: any, from: any, next: any) => {
    if (to.meta.auth) {
      if (loggedIn) {
        next();
      }
      next.redirect('/');
    } else {
      next();
    }
  }

  useEffect(() => {
    if (loggedIn) {
      getBooks(directus).then((books) => {
        books.data?.forEach((booksData) => {
          booksData.translations?.forEach((id) => {
            getTranslations(directus, id?.toString()).then((translations) => {
              const tempTranslations: BookTranslation[] = [];
              translations.data?.forEach((translation) => {
                tempTranslations.push(translation as BookTranslation);
              });
              setTranslations(tempTranslations);
            });
          });
        });
      });
    }
  }, [loggedIn]);

  return (
    <Fragment>
      {loggedIn ? (
        <IconButton
          aria-label="toggle menu"
          onClick={toggleDrawer(!drawerOpen, setDrawerOpen)}
        >
          <MenuIcon />
        </IconButton>
      ) : (
        <div></div>
      )}

      <Router>
        <GuardProvider guards={[requireLogin]}>
          <Switch>
            <GuardedRoute exact path="/read" meta={{ auth: true }}>Reading...</GuardedRoute>
            <Route exact path="/">
              <Grid
                container
                direction="column"
                justify="center"
                alignItems="center"
              >
                <Fragment>
                  {loggedIn ? (
                    <Landing translations={translations} />
                  ) : (
                    <Login
                      directus={directus}
                      setDirectus={setDirectus}
                      setLoggedIn={setLoggedIn}
                    />
                  )}
                </Fragment>
              </Grid>
            </Route>
          </Switch>
        </GuardProvider>
      </Router>

      {loggedIn ? (
        <SwipeableDrawer
          anchor={"left"}
          open={drawerOpen}
          onClose={toggleDrawer(false, setDrawerOpen)}
          onOpen={toggleDrawer(true, setDrawerOpen)}
        >
          <Button
            style={{
              margin: 20,
            }}
            variant="contained"
            onClick={(event) => {
              directus.auth.logout().then((v) => {
                setLoggedIn(false);
              });
            }}
          >
            Log out
          </Button>
        </SwipeableDrawer>
      ) : (
        <div></div>
      )}
    </Fragment>
  );
};

export default App;
