import React from "react";
import distributionOptions from "./DistrbutionOptions";
import { Link } from "react-router-dom";
// import RouteDistribution from "./RouteDistribution";
// TODO: figure out how to route to another page
const DistributionList = () => {
  return (
    <div>
      {/* <Router> */}
      <h2>List of Distributions</h2>
      <ul>
        {/* <Link to={`/test`}>{"test"}</Link> */}

        {distributionOptions.map(v => (
          <li key={v.value}>
            <Link to={`/${v.value}`}>{v.label}</Link>
          </li>
        ))}
      </ul>
      {/* <Switch>
        <Route exact path={`/distributions/test`}>
          <RouteDistribution label={"test"} />
        </Route> */}
      {/* {distributionOptions.map(v => (
          <div key={`route-${v.value}`}>
            <Route exact path={`/distributions/${v.value}`}>
              <RouteDistribution label={v.label} />
            </Route>
          </div>
        ))} */}
      {/* </Switch> */}
      {/* </Router> */}
    </div>
  );
};
export default DistributionList;
