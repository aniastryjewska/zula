import { Button, Grid, Typography } from "@material-ui/core";
import React, { FunctionComponent, Fragment } from "react";
import { BookTranslation } from "../model";
import Image from "material-ui-image";
import { Link, Redirect, useHistory } from "react-router-dom";

interface LandingProps {
  translations: BookTranslation[];
  setCurrentTranslation: React.Dispatch<
    React.SetStateAction<BookTranslation | undefined>
  >;
}

export const Landing: FunctionComponent<LandingProps> = (props) => {
  const history = useHistory();
  return (
    <div
      style={{
        width: "70%",
        maxWidth: "750",
        textAlign: "center",
      }}
    >
      <Typography variant="h4">Welcome to Zula</Typography>
      <br></br>
      {props.translations.map((translation) => {
        return (
          <Fragment>
            <span>
              <strong>{translation.title}</strong>
            </span>
            <Button
              variant="contained"
              onClick={() => {
                props.setCurrentTranslation(translation);
                history.push("/read");
              }}
              style={{
                margin: 20,
              }}
            >
                Read Now!
            </Button>
            <Image
              src={translation.config[0]}
              aspectRatio={1 / 1}
              disableSpinner
              style={{ marginTop: 10 }}
            />
          </Fragment>
        );
      })}
    </div>
  );
};
