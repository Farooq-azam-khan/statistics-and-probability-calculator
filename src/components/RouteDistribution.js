import React from "react";
import PropType from "prop-types";

const RouteDistribution = props => {
  return (
    <div>
      <h2>${props.label}</h2>
    </div>
  );
};

RouteDistribution.propTypes = {
  label: PropType.string
};

export default RouteDistribution;
