import { Grid, Typography } from "@material-ui/core";
import React, { FunctionComponent, Fragment } from "react";
import { BookTranslation } from "../model";
import Image from "material-ui-image";

interface LandingProps {
  translations: BookTranslation[];
}

export const Landing: FunctionComponent<LandingProps> = (props) => {
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
