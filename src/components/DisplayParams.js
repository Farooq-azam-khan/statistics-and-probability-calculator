import React from "react";
import DistributionParam from "./DistributionParam";
import { Row } from "react-bootstrap";

const DisplayParams = props => {
  return (
    <div
      style={{
        display: "flex",
        backgroundColor: "lightgreen",
        margin: "2rem",
        padding: "1rem",
        textAlign: "center",
        justifyContent: "center"
      }}
    >
      <Row>
        {Object.keys(props.params).map(k => {
          return (
            <div key={k}>
              <DistributionParam
                keyName={k}
                param={props.params[k]}
                onChange={props.onChange}
              />
            </div>
          );
        })}
      </Row>
    </div>
  );
};

export default DisplayParams;
