import React from "react";

const DistributionParam = props => {
  return (
    <span>
      <label>{props.keyName}</label>
      <input
        id={props.keyName}
        className="form-control"
        type="number"
        value={props.param}
        onChange={props.onChange}
      />
    </span>
  );
  // return <input value={props.param} />;
};

export default DistributionParam;
