import { Directus } from "@directus/sdk";
import { Button, TextField } from "@material-ui/core";
import React, { FunctionComponent, Fragment, useState } from "react";
import { ZulaMap } from "../model";

interface LoginProps {
    directus: Directus<ZulaMap>
    setDirectus: React.Dispatch<React.SetStateAction<Directus<ZulaMap>>>
    setLoggedIn: React.Dispatch<React.SetStateAction<boolean>>
}

const loginUser = async (
    directus: Directus<ZulaMap>,
    userEmail: string,
    userPassword: string,
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

export const Login: FunctionComponent<LoginProps> = (props) => {
    const [errors, setErrors] = useState(null)
    return (
        <Fragment>
            <form autoComplete="off" onSubmit={(event) => {
                event.preventDefault()
                const target = event.target as typeof event.target & {
                    email: { value: string },
                    password: { value: string }
                }
                loginUser(props.directus, target.email.value, target.password.value)
                .then((loggedInDirectus) => {
                    props.setDirectus(loggedInDirectus)
                    props.setLoggedIn(true)
                })
                .catch((error) => {
                    console.log(error)  
                })
            }}>
                <div>
                    <br></br>
                    <TextField
                        name="email"
                        required
                        id="userEmail"
                        label="Email"
                        defaultValue="admin@example.com"
                        variant="outlined"
                    />
                    <br></br><br></br>
                    <TextField
                        name="password"
                        required
                        id="userPassword"
                        label="Password"
                        type="password"
                        autoComplete="current-password"
                        variant="outlined"
                    />
                    <br></br><br></br>
                    <Button type="submit" variant="contained">Login</Button>
                </div>
            </form>
        </Fragment>
    );
};
