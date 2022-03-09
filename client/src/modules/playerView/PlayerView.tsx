import { Box, Button } from "@mui/material";
import AddEditPlayer from "modules/playersList/components/AddEditPlayer";
import { getPlayerById } from "modules/playersList/selectors";
import { useSelector } from "react-redux";
import { Navigate, useParams } from "react-router-dom";
import { API_POST_TYPES, postApi } from "utils/apis";

const PlayerView = () => {
  const { id } = useParams();
  const player = useSelector(getPlayerById(id));
  const deletePlayer = async () => {
    if (!player) {
      return;
    }
    const result = await postApi(
      `players/${player.id}`,
      {},
      API_POST_TYPES.DELETE
    );
    console.log(result);
  };

  if (!player) {
    return <Navigate to="/players" replace />;
  }
  return (
    <Box>
      {player.name}
      <AddEditPlayer player={player} />
      <Button onClick={deletePlayer}>Delete</Button>
    </Box>
  );
};

export default PlayerView;
