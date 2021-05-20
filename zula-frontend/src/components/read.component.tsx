import { Grid, IconButton, Typography } from "@material-ui/core";
import React, { FunctionComponent, Fragment, useState } from "react";
import { BookTranslation } from "../model";
import Image from "material-ui-image";
import ArrowForwardIcon from "@material-ui/icons/ArrowForward";
import ArrowBackIcon from "@material-ui/icons/ArrowBack";

interface ReadProps {
  translation: BookTranslation;
}

export const Read: FunctionComponent<ReadProps> = (props) => {
  const [imageLinks, setImageLinks] = useState<string[]>(
    props.translation.config
  );
  const [currentIndex, setCurrentIndex] = useState<number>(0);

  return (
    <Fragment>
      <div>
        <IconButton
          aria-label="go back 1 page"
          onClick={() => {
            if (currentIndex > 0) {
              const newIndex = currentIndex - 1;
              setCurrentIndex(newIndex);
            }
          }}
        >
          <ArrowBackIcon />
        </IconButton>
        <IconButton
          aria-label="go forward 1 page"
          onClick={() => {
            if (currentIndex < imageLinks.length) {
              const newIndex = currentIndex + 1;
              setCurrentIndex(newIndex);
            }
          }}
        >
          <ArrowForwardIcon />
        </IconButton>
      </div>
      <div
        style={{
          width: "70%",
          maxWidth: "750",
          textAlign: "center",
        }}
      >
        <Image
          src={imageLinks[currentIndex]}
          aspectRatio={1 / 1}
          disableSpinner
          style={{ marginTop: 10 }}
        />
      </div>
    </Fragment>
  );
};
